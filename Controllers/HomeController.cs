using Microsoft.AspNetCore.Mvc;
using ProfileManagement.Domain;
using ProfileManagement.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;

namespace ProfileManagement.Controllers
{
    public class HomeController : Controller
    {
        private ProfileMaster _profileMaster;
        public HomeController()
        {
            _profileMaster = new ProfileMaster();
        }
        public IActionResult Index()
        {
            List<ProfileMasterModel> profiles = _profileMaster.GetProfiles();
            return View(profiles);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(ProfileMasterModel profile)
        {
            if (ModelState.IsValid)
            {
                _profileMaster.AddProfile(profile);
                return RedirectToAction("Index");
            }
            else
                return View();
        }

        public IActionResult Update(int id)
        {
            ProfileMasterModel profile = _profileMaster.GetProfile(id);            
            return View(profile);
        }

        [HttpPost]
        [ActionName("Update")]
        public IActionResult Update_Post(ProfileMasterModel profile)
        {
            if (ModelState.IsValid)
            {
                _profileMaster.AddProfile(profile);
                return RedirectToAction("Index");
            }
            else
                return View();
        }

        [HttpPost]
        public IActionResult Delete(int id)
        {
            _profileMaster.DeleteProfile(id);
            return RedirectToAction("Index");
        }
    }
}