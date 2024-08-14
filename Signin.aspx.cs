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

public partial class signin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Form["cmdDangky"] != null)
        {
            string insert = "";
            try
            {
                string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
                SqlConnection conn = new SqlConnection(connectString);
                conn.Open();
                string user = Request.Form["user"];
                string pass = Request.Form["pass"];
                string hoten = Request.Form["hoten"];
                string diachi = Request.Form["diachi"];
                string phone = Request.Form["phone"];
                string sex = Request.Form["sex"];
                string ngaysinh = Request.Form["ngaysinh"];
                string quocgia = Request.Form["quocgia"];
                string tinh="other";
                if(quocgia.ToString().Equals("vn"))
                     tinh= Request.Form["tinh"];
                string cauhoi = Request.Form["cauhoi"];
                string cauTL = Request.Form["cauTL"];
                string email = Request.Form["email"];
                insert = "insert into thanhvien(username,pass,loaitk,tenkh,diachi,dienthoai,phai,namsinh,quocgia,thanhpho,cauhoi,cautraloi,email) values(";
                insert += "N'" + user + "',N'" + pass + "','user',N'" + hoten + "',N'" + diachi + "','" + phone + "','" + sex + "','" + ngaysinh + "',N'" + quocgia + "',N'" + tinh + "',N'" + cauhoi + "',N'" + cauTL + "','" + email + "')";
                SqlCommand cmd = new SqlCommand(insert, conn);
                cmd.ExecuteNonQuery();
                if (Session["user"] == null)
                    Application["sothanhvien"] = (int)Application["sothanhvien"] + 1;
                else
                    Session["user"] = null;
                Session["User"] = user;
                Session["loaitk"] = "user";
                string url = Session["url"].ToString();
                Session["dadangnhap"] = true;
                if (Request.Form["url"] != null)
                    url = Request.Form["url"].ToString();

                //Response.Write(Session["url"].ToString());
                Response.Redirect(url);
            }
            catch (Exception exc)
            {
                Response.Write(insert);
            }
        }
    }
}
