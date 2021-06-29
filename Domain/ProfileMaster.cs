using Microsoft.Extensions.Configuration;
using ProfileManagement.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace ProfileManagement.Domain
{
    public class ProfileMaster
    {
        private static string _connectionString;

        public ProfileMaster()
        {
            var configuation = GetConfiguration();
            _connectionString = configuation.GetSection("ConnectionString").Value;
        }

        public List<ProfileMasterModel> GetProfiles()
        {            
            List<ProfileMasterModel> profiles = new List<ProfileMasterModel>();
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetProfiles"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@FilterActive", SqlDbType.Bit).Value = false;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = -1;

                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            profiles.Add(new ProfileMasterModel
                            {
                                Id = Convert.ToInt64(sdr["Id"]),
                                FullName = sdr["FullName"].ToString(),
                                EmailId = sdr["EmailId"].ToString(),
                                Mobile = sdr["Mobile"].ToString(),
                                IsActive = Convert.ToBoolean(sdr["IsActive"]),
                                CreatedOnStr = Convert.ToDateTime(sdr["CreatedOn"]).ToString("dd/MM/yyyy")
                            });
                        }
                    }
                    con.Close();
                }
            }

            return profiles;
        }

        public ProfileMasterModel GetProfile(int id)
        {
            ProfileMasterModel profile = new ProfileMasterModel();
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetProfiles"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@FilterActive", SqlDbType.Bit).Value = false;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            profile.Id = Convert.ToInt64(sdr["Id"]);
                            profile.FullName = sdr["FullName"].ToString();
                            profile.EmailId = sdr["EmailId"].ToString();
                            profile.Mobile = sdr["Mobile"].ToString();
                            profile.IsActive = Convert.ToBoolean(sdr["IsActive"]);
                            profile.CreatedOnStr = Convert.ToDateTime(sdr["CreatedOn"]).ToString("dd/MM/yyyy");
                        }
                    }
                    con.Close();
                }
            }

            return profile;
        }

        public void AddProfile(ProfileMasterModel profile)
        {            
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_AddProfile"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = profile.Id;
                    cmd.Parameters.Add("@FullName", SqlDbType.NVarChar).Value = profile.FullName;
                    cmd.Parameters.Add("@EmailId", SqlDbType.NVarChar).Value = profile.EmailId;
                    cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar).Value = profile.Mobile;
                    cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = profile.IsActive ? 1 : 0;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        public void DeleteProfile(int id)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_DeleteProfile"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        private IConfigurationRoot GetConfiguration()
        {
            var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            return builder.Build();
        }
    }
}
