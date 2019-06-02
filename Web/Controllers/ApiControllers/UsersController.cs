using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Entities;

namespace FollowersApp.Controllers.ApiControllers
{
    public class UsersController : ApiController
    {
        [HttpGet]
        public User Get()
        {
            try
            {
                return new User();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
