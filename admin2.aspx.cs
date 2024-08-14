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

public partial class admin2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["user"] == null || Session["loaitk"] == null)
        //    Response.Redirect("Default.aspx");
        //Response.Write(Session["loaitk"].ToString()!="admin");
        //if (!Session["loaitk"].ToString().Equals("admin"))
        //    Response.Redirect("Default.aspx");
        if (!Page.IsPostBack)
            connect();

    }
    public void connect()
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        String sql = "select masp,tensp,tt,soluong,gia from sanpham";
        DataSet ds = new DataSet();
        connection.Open();
        SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
        adapter.Fill(ds);
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
    }
    /*protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        String ma = GridView1.DataKeys[e.RowIndex].Value.ToString();
        String sql1 = "delete from sanpham where masp='" + ma + "'";
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        connection.Open();
        SqlCommand cmd1 = new SqlCommand(sql1, connection);
        cmd1.ExecuteReader();
        connection.Close();
        connect();
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        connect();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        GridView1.EditIndex = -1;
        connect();
    }
    public void update(String masp, String tensp, int gia, int sl, String tt)
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        try
        {
            connection.Open();
            String sql = "update sanpham set tensp='" + tensp + "',gia=" + gia + ",soluong=" + sl + ",tt='" + tt + "' where masp='" + masp + "'";
            //Response.Write(sql);
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.ExecuteNonQuery();
        }
        catch (SqlException sqle)
        {
            //String sql = "update sanpham set tensp='" + tensp + "',gia=" + gia + ",soluong=" + sl + ",kichco='" + kichco + "',bangtan='" + bangtan + "',camera='" + camera + "',xuatxu='" + xuatxu + "',dactinh='" + dactinh + "' where masp='" + masp + "'";
            //Response.Write(sql);
            return;
        }
        finally
        {
            connection.Close();
        }
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            string tensp = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[2].Controls[0])).Text;
            string tt = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[3].Controls[0])).Text;
            int soluong = int.Parse(((TextBox)(GridView1.Rows[e.RowIndex].Cells[4].Controls[0])).Text);
            int gia = int.Parse(((TextBox)(GridView1.Rows[e.RowIndex].Cells[5].Controls[0])).Text);
            //test.InnerText = tensp;

            update(GridView1.DataKeys[e.RowIndex].Value.ToString(), tensp, gia, soluong, tt);
            GridView1.EditIndex = -1;
            //Label5.Text = GridView1.DataKeys[e.RowIndex].Value.ToString();
            connect();
        }
        catch (Exception ex)
        {

        }

    }*/
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        connect();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = int.Parse(e.CommandArgument.ToString());
        //test.InnerText = index.ToString();
        Page.RegisterStartupScript("xacnhan", "<script>function test(){ return confirm('Xoa dong thu " + index + "?'); }</script>");
        //test.InnerText = index.ToString();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //LinkButton del = (LinkButton)e.Row.FindControl("delete");
            //del.OnClientClick = string.Format("return confirm('delete ha nhoc');");
            test.InnerText = "";
            LinkButton bt = (LinkButton)e.Row.Cells[0].Controls[0];
            bt.OnClientClick = string.Format("test()");
            test.InnerText = "xoa";
        }
          
    }
}
