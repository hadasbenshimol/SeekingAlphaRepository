using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entities.ViewModels;

namespace FollowersApp.Models
{
    public class FollowingPageModel
    {
        public int LoggedInUserId { get; set; }
        public string LoggedInUserName { get; set; }
        public List<UserViewModel> UsersList { get; set; }
    }
}