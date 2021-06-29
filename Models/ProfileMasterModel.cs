using System;
using System.ComponentModel.DataAnnotations;

namespace ProfileManagement.Models
{
    public class ProfileMasterModel
    {
        public Int64 Id { get; set; }
        [Required]
        [StringLength(255, ErrorMessage = "Name cannot be longer than 255 characters.")]
        public string FullName { get; set; }
        [Required]
        [EmailAddress(ErrorMessage = "Invalid Email Address")]
        [StringLength(255, ErrorMessage = "EmailId cannot be longer than 255 characters.")]
        public string EmailId { get; set; }
        [Required]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$", ErrorMessage = "Not a valid phone number")]
        public string Mobile { get; set; }
        public bool IsActive { get; set; }
        public string CreatedOnStr { get; set; }        
        public int CreatedBy { get; set; }
    }
}
