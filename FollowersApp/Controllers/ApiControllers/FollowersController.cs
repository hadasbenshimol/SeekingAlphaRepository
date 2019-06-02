using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Web;
using System.Web.Http;
using Business;
using Entities;
using Entities.ViewModels;

namespace FollowersApp.Controllers.ApiControllers
{
    public class FollowersController : ApiController
    {
        [HttpGet]
        public List<UserDetails> Get()
        {
            var usersList = FollowersLogic.GetUsersList();
            return usersList;
        }

        [HttpPut]
        public HttpResponseMessage Put(UsersUpdates users)
        {
            var success = FollowersLogic.UpdateUsers(users.LoggedinUser, users.UserToFollow);
            if (success)
                return Request.CreateErrorResponse(HttpStatusCode.OK, "Follower Updated Successfully! ");
            return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,
                "An error occured while trying to update followers, Please try again later.");
        }
    }

    public class UsersUpdates
    {
        public string UserToFollow { get; set; }
        public string LoggedinUser { get; set; }
    }
}