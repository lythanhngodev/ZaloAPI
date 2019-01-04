using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZaloCSharpSDK;

namespace ZaloAPI
{
    public partial class zalo : System.Web.UI.Page
    {
        public string code;
        public string json_dsbb;
        public string tranghientai;
        public string access_token_oa = "wJ3J73dXZ6dZFzyRDU-3P-0us1OoyE02e5so2oR2YGEGSO4kElEa4x5zWnaWgyGLeoBKP7M5Z6_T1zzyIw_yOkeppar0-E5CqsZOGbRqnKpHNTz2LSFvS-8MsNjadO49ioY331sxknVBRPSUHjwPQyPBtbv2z_DOq7kjQ4RKarxrOf9yM_ES5SnJXIKVvemmYpBNH22MYqdm0fDiTDF94FnlxJqioi8pzbZFG6Bu-b3NQSPVS-hkBCTqxrrJmhnmY7srSrl3iWDrCEBcQaGu-8jf";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    tranghientai = "localhost:1834/zalo.aspx";
                    Zalo3rdAppClient appClient = new Zalo3rdAppClient(new Zalo3rdAppInfo(2127518896466871150, "OUKlCdL8uYLIMe73QB65", tranghientai));
                    string loginUrl = appClient.getLoginUrl();
                    code = Request.QueryString["code"];
                    JObject token = appClient.getAccessToken(code);

                    if (string.IsNullOrEmpty(code))
                        Response.Redirect(loginUrl.ToString());
                    else
                    {
                        string chuoitoken = token.Property("access_token").Value.ToString();
                        JObject profile = appClient.getProfile(chuoitoken, "name,picture,id,userIdByOA");
                        // userIdByOA => ID cần gửi tin
                        txtHDinfo.Value = profile.ToString();
                        //txtTenNguoiDung.Text = profile.Property("name").Value.ToString();
                        txtTenNguoiDung.Text = "NTSoft";
                        JObject invitableFriends = appClient.getInvitableFriends(chuoitoken, 0, 0, "id, name, picture, gender");
                        int soluong = 0;
                        soluong = int.Parse(invitableFriends["summary"]["total_count"].ToString());

                        //JObject banbe = appClient.getInvitableFriends(chuoitoken, 0, soluong, "id, name, picture, gender,userIdByOA");
                        JObject banbe = JObject.Parse(JObject.Parse(new WebClient().DownloadString("https://openapi.zalo.me/v2.0/oa/getfollowers?access_token=w8i4LtUoispYX0XGUxoyOk633rryexLkf-1d5N-lg6-twqXHLRs2Q8dZH54MtvCfmfqXG2ltwtBMcoPA7lVnTSMD94WZnUGQ-89M91Yua6F-yoDS5CdZ8y-39s8szEymwhqQ3t_gqZ7ZfHft1CV83kg267HtkiWuWkv_V6oYgpwnWKX6RkkcVx6HTZ9Gsy9PZu4r6NRMW27hW4qV0CU4TfYdGZL-neDLw_bFQ16D_JNij0S86SB8OVFx6IOfagaSnVb9JmcVWn_qw5DIhGw22dQhj6m&data={offset=0,count=5}"))["data"].ToString());
                        string[,] mangid = new string[banbe["followers"].Count<JToken>(), 3];
                        ZaloOaInfo zaloOaInfo = new ZaloOaInfo(739460368435099423, "n30YrpHUT626CuAUWW15");
                        ZaloOaClient oaClient = new ZaloOaClient(zaloOaInfo);
                        for (int i = 0; i < banbe["followers"].Count<JToken>(); i++)
                        {
                            long idphu = long.Parse(banbe["followers"][i].Value<JToken>()["user_id"].ToString());
                            JObject a1 = oaClient.getProfile(idphu);
                            mangid[i, 0] = idphu.ToString();
                            mangid[i, 1] = a1["data"].Value<JToken>()["avatar"].ToString();
                            mangid[i, 2] = a1["data"].Value<JToken>()["displayName"].ToString();
                        }
                        json_dsbb = JsonConvert.SerializeObject(mangid);
                    }

                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string GuiTinNhan(object[] userId, object noidung)
        {
            ZaloOaInfo zaloOaInfo = new ZaloOaInfo(739460368435099423, "n30YrpHUT626CuAUWW15");
            ZaloOaClient oaClient = new ZaloOaClient(zaloOaInfo);
            JObject sendTextMessage=null;
            foreach (object x in userId)
            {
                sendTextMessage = oaClient.sendTextMessage(long.Parse(x.ToString()), noidung.ToString());
            }
            //JObject sendTextMessage = oaClient.sendTextMessage(long.Parse(userId.ToString()), noidung.ToString());
            return sendTextMessage.ToString();
        }
        [System.Web.Services.WebMethod]
        public static string LayTin(object userId)
        {
            string s;
            using (WebClient webClient = new WebClient())
            {
                webClient.Encoding = System.Text.Encoding.UTF8;
                s = webClient.DownloadString("https://openapi.zalo.me/v2.0/oa/conversation?access_token="+ (new zalo().access_token_oa) + "&data={user_id=" + userId.ToString() + ",offset=0,count=10}");
                //return "https://openapi.zalo.me/v2.0/oa/conversation?access_token=" + (new zalo().access_token_oa) + "&data={user_id=" + userId.ToString() + ",offset=0,count=10}";
            }
            JObject banbe = JObject.Parse(JObject.Parse(s).ToString());
            return banbe.ToString();
        }
    }
}