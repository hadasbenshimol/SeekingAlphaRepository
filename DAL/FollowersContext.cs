using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
//using FollowersApp.Models;

namespace DAL
{
    public class FollowersDBContext : DbContext
    {
        public FollowersDBContext()
        {
            this.Configuration.LazyLoadingEnabled = true;
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Group> Groups { get; set; }
    }
}
