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

public partial class admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null || Session["loaitk"] == null)
            Response.Redirect("Default.aspx");
        //Response.Write(Session["loaitk"].ToString()!="admin");
        if(!Session["loaitk"].ToString().Equals("admin"))
            Response.Redirect("Default.aspx");
        if(!Page.IsPostBack)
            connect();
        
    }
    public void connect()
    {
        try
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
        catch (Exception e)
        {
            Response.Redirect("error.aspx");
        }
    }
    protected void cmdXoa_click(object sender, EventArgs e)
    {
        string dk = "";
        foreach (GridViewRow gv in GridView1.Rows)
        {
            CheckBox chk = (CheckBox)gv.FindControl("check");
            Label ma=(Label)gv.FindControl("masp");
            if (chk.Checked)
                if (dk == "")
                    dk = "'" + ma.Text.ToString() + "'";
                else
                    dk += ",'" + ma.Text.ToString() + "'";

        }
        string sql2 = "select masp from chitiethoadon where masp in (" + dk + ")";
        String sql1 = "delete from sanpham where masp in (" + dk + ")";
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        connection.Open();
        SqlCommand cmd1 = new SqlCommand(sql2, connection);
        SqlDataReader reader = cmd1.ExecuteReader();
        if (reader.Read())
            Session["err_delete"] = 1;
        else
        {
            cmd1.Dispose();
            cmd1 = new SqlCommand(sql1, connection);
            cmd1.ExecuteNonQuery();
        }
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
            string tensp = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[3].Controls[0])).Text;
            string tt = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[4].Controls[0])).Text;
            int soluong = int.Parse(((TextBox)(GridView1.Rows[e.RowIndex].Cells[5].Controls[0])).Text);
            int gia = int.Parse(((TextBox)(GridView1.Rows[e.RowIndex].Cells[6].Controls[0])).Text);
            //test.InnerText = tensp;
            
            update(GridView1.DataKeys[e.RowIndex].Value.ToString(), tensp,gia,soluong,tt);
            GridView1.EditIndex = -1;
            //Label5.Text = GridView1.DataKeys[e.RowIndex].Value.ToString();
            connect();
        }
        catch (Exception ex)
        {
            
        }
        
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        connect();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
          {
              LinkButton del = (LinkButton)e.Row.FindControl("delete");
              del.OnClientClick = string.Format("return confirm('delete ha nhoc');");
          }
    }
}
