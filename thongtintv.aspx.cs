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

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        conn();
    }
    protected void conn()
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        connection.Open();
        String sql = "select distinct loaitk from thanhvien";
        SqlCommand cmd = new SqlCommand(sql, connection);
        DropDownList1.DataSource = cmd.ExecuteReader();
        DropDownList1.DataTextField = "loaitk";
        DropDownList1.DataValueField="loaitk";
        DropDownList1.DataBind();
        connection.Close();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        String drvalue = DropDownList1.SelectedValue;
        String sql = "select username,tenkh,namsinh,phai,diachi,dienthoai from thanhvien where loaitk='" + drvalue + "'";
        SqlCommand cmd = new SqlCommand(sql, connection);
        connection.Open();
        GridView1.DataSource = cmd.ExecuteReader();
        GridView1.DataBind();
        connection.Close();
        connection.Dispose();
    }
}
