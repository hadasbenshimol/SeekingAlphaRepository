using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;
using Business;
using Entities;
using Entities.ViewModels;
using FollowersApp.Models;

namespace FollowersApp.Controllers
{
    public class FollowersController : Controller
    {
        // GET: Followers
        public ActionResult Index()
        {
            //Check cookie "user_id" before calling the API
            var indexPageModel = new FollowingPageModel();
            var userIdCookie = Request.Cookies["user_id"];

            if (userIdCookie != null && !string.IsNullOrEmpty(userIdCookie.Value))
            {
                var usersList = new List<UserViewModel>();

                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri("http://localhost:62173/api/followers/");
                    //HTTP GET
                    var responseTask = client.GetAsync("get");
                    responseTask.Wait();

                    var result = responseTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        var readTask = result.Content.ReadAsAsync<List<UserDetails>>();
                        readTask.Wait();

                        var usersDetailsList = readTask.Result;
                        if (usersDetailsList != null)
                        {
                            usersList.AddRange(usersDetailsList.Select(ud => new UserViewModel
                            {
                                Id = ud.Id,
                                Name = ud.Name,
                                GroupName = ud.GroupName,
                                Followers = !string.IsNullOrEmpty(ud.FollowersList)
                                    ? ud.FollowersList.Split(',').ToList()
                                    : null,
                            }));
                        }
                    }
                }

                var loggedInUser = UsersLogic.GetUser(int.Parse(userIdCookie.Value));
                indexPageModel.LoggedInUserId = loggedInUser.Id;
                indexPageModel.LoggedInUserName = loggedInUser.Name;
                indexPageModel.UsersList = usersList.Where(u => u.Id != loggedInUser.Id).OrderBy(c => c.Id).ToList();
            }

            return View(indexPageModel);
        }
    }
}