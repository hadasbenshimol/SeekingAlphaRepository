using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Configuration;
using System.Text;
using System.Threading.Tasks;
using DAL;
using Entities;
using Entities.ViewModels;

namespace Business
{
    public static class FollowersLogic
    {
        public static List<UserDetails> GetUsersList()
        {
            try
            {
                return new DbAccess().GetUsers();
            }
            catch (Exception e)
            {
                //Log error 
                return null;
            }
        }
        /// <summary>
        /// Update the user following list with the userToFollow
        /// </summary>
        /// <param name="user"></param>
        /// <param name="userToFollow"></param>
        public static bool UpdateUsers(string user, string userToFollow)
        {
            try
            {
                new DbAccess().UpdateUsers(int.Parse(user), int.Parse(userToFollow));
                return true;
            }
            catch (Exception e)
            {
                //Log error
                return false;
            }
        }
    }
}
