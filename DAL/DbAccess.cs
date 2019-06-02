using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;

namespace DAL
{
    public class DbAccess
    {
        public List<UserDetails> GetUsers()
        {
            try
            {
                using (var ctx = new FollowersDBContext())
                {
                    var usersList = ctx.Database.SqlQuery<UserDetails>("exec sp_GetUsersTbl").ToList();

                    return usersList;
                }
            }
            catch (Exception ex) 
            {
                //Log exception
                throw;
            }
        }

        public void UpdateUsers(int user, int userToFollow)
        {
            try
            {
                using (var ctx = new FollowersDBContext())
                {
                    var rowsEffected = ctx.Database.ExecuteSqlCommand(
                        "sp_UpdateFollowers @userId, @followingUserId",
                        new SqlParameter("userId", user),
                        new SqlParameter("followingUserId", userToFollow)
                    );
                }
            }
            catch (Exception ex)
            {
                //Log exception
                throw;
            }
        }

        public User GetUser(int id)
        {
            try
            {
                using (var ctx = new FollowersDBContext())
                {
                    var user = ctx.Users.Find(id);
                    return user;
                }
            }
            catch (Exception e)
            {
                throw;
            }
        }
    }
}
