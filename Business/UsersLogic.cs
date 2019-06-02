using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using Entities;

namespace Business
{
    public static class UsersLogic
    {
        public static User GetUser(int id)
        {
            return new DbAccess().GetUser(id);
        }
    }
}

