using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class checklogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Form["cmdDangnhap"] != null)
        {
            Response.ContentType = "text/html;charset=utf-8";
            String strConn = "Data source=localhost; " + "initial catalog=dotnet; integrated security=true";
            SqlConnection conn = new SqlConnection(strConn);
            conn.Open();
            string sql = "select * from thanhvien";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            String user = Request.Form["txtuser"];
            user = user.ToLower();
            String pass = Request.Form["txtpass"];
            while (dr.Read())
            {
                string username = dr["username"].ToString();
                username = username.ToLower();

                if (user == username && pass == dr["pass"].ToString())
                {
                    Session["User"] = user;
                    Session["loaitk"] = dr["loaitk"].ToString();
                    Session["error"] = null;
                    Application["sothanhvien"] = (int)Application["sothanhvien"] + 1;
                    Session["dadangnhap"] = true;
                }
                else
                    Session["error"] = "Nhập sai user hoặc pass";
            }
            string url = Session["url"].ToString();
            if (Request.Form["url_donhang"] != null)
                url = Request.Form["url_donhang"].ToString();
            
            //Response.Write(Session["url"].ToString());
            Response.Redirect(url);
        }    
    }
}
