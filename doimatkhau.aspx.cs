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

public partial class doimatkhau : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["user"] == null)
            Response.Redirect("Default.aspx");
        else if (Request.Form["doi"] != null)
        {
            string passcu = Request.Form["txtpasscu"].ToString();
            string passmoi = Request.Form["txtpassmoi"].ToString();
            Response.ContentType = "text/html;charset=utf-8";
            string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectString);
            conn.Open();
            string sql = "select pass from thanhvien where username like '" + Session["user"].ToString() + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();
            string pass = dr["pass"].ToString();
            if (passcu.Equals(pass))
            {
                sql = "update thanhvien set pass='" + passmoi + "' where username like '" + Session["user"].ToString() + "'";
                cmd.Dispose();
                dr.Dispose();
                cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                Session["ketqua"] = 1;
            }
            else
            {
                Session["ketqua"] = 0;
            }
        }
        
            
    }
}
