using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public int Group_Id { get; set; }
        [ForeignKey("Id")]
        public virtual Group Group { get; set; }
       
    }

    public class UserDetails
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string GroupName { get; set; }
        public string FollowersList { get; set; }
    }
}

namespace Entities.ViewModels
{
    public class UserViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string GroupName { get; set; }
        public List<string> Followers { get; set; }
        public int NumOfFollowers
        {
            get { return Followers != null ? Followers.Count() : 0; }
        }
    }
}