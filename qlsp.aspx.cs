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

public partial class Default4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
            connect();
        
    }
    protected void connect() 
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        String sql = "select * from sanpham";
        String sql1 = "select * from nhasx";
        String sql2="select * from loai";
        connection.Open();
        DataSet ds = new DataSet();
        SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
        SqlDataAdapter adapter1 = new SqlDataAdapter(sql1, connection);
        SqlDataAdapter adapter2 = new SqlDataAdapter(sql2, connection);
        adapter.Fill(ds);
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
        adapter1.Fill(ds,"nhasx");
        DropDownList1.DataSource = ds.Tables["nhasx"];
        DropDownList1.DataTextField = "tennhasx";
        DropDownList1.DataValueField = "manhasx";
        DropDownList1.DataBind();
        adapter2.Fill(ds, "loai");
        DropDownList2.DataSource = ds.Tables["loai"];
        DropDownList2.DataTextField ="tenloai";
        DropDownList2.DataValueField = "maloai";
        DropDownList2.DataBind();
    }
    protected void add()
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        String sql = "insert into sanpham(masp,manhasx,maloai,tensp,mota,gia,soluong,kichco,bangtan,camera,GPRS,xuatxu,dactinh) values(@masp,@manhasx,@maloai,@tensp,@mota,@gia,@sl,@kc,@btan,@camera,@GPRS,@xuatxu,@dtinh)";
        try
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.Parameters.AddWithValue("@masp",TextBox1.Text);
            cmd.Parameters.AddWithValue("@manhasx", DropDownList1.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@maloai", DropDownList2.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@tensp", TextBox2.Text);
            cmd.Parameters.AddWithValue("@mota", TextBox3.Text);
            cmd.Parameters.AddWithValue("@gia", TextBox4.Text);
            cmd.Parameters.AddWithValue("@sl", TextBox5.Text);
            cmd.Parameters.AddWithValue("@kc", TextBox6.Text);
            cmd.Parameters.AddWithValue("@btan", TextBox7.Text);
            cmd.Parameters.AddWithValue("@camera", TextBox8.Text);
            cmd.Parameters.AddWithValue("@GPRS", TextBox9.Text);
            cmd.Parameters.AddWithValue("@xuatxu", TextBox10.Text);
            cmd.Parameters.AddWithValue("@dtinh", TextBox11.Text);
            cmd.ExecuteNonQuery();
            Response.Write("ok rui");
            connect();
        }
        catch (SqlException sqlex)
        {
            Response.Write(sqlex.Message);
            return;
        }
        finally 
        {
            connection.Close(); 
        }
    }
    public void update(String masp, String tensp, int gia, int sl, String kichco, String bangtan, String camera, String xuatxu, String dactinh)
    {
        String conn = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection connection = new SqlConnection(conn);
        try
        {
            connection.Open();
            String sql = "update sanpham set tensp='" + tensp + "',gia=" + gia + ",soluong=" + sl + ",kichco='" + kichco + "',bangtan='" + bangtan + "',camera='" + camera + "',xuatxu='" + xuatxu + "',dactinh='" + dactinh + "' where masp='" + masp + "'";
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.ExecuteNonQuery();
        }
        catch (SqlException sqle)
        {
            Response.Write(sqle.Message);
            return;
        }
        finally
        {
            connection.Close();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        connect();
    }
    protected void Buttonthem_Click(object sender, EventArgs e)
    {
        Buttonthem.OnClientClick = string.Format("return confirm('co mun Them ko');");
        add();
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        connect();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txttensp = (TextBox)GridView1.Rows[e.RowIndex].FindControl("tensp");
        TextBox txtgia = (TextBox)GridView1.Rows[e.RowIndex].FindControl("gia");
        TextBox txtsl = (TextBox)GridView1.Rows[e.RowIndex].FindControl("soluong");
        TextBox txtkichco = (TextBox)GridView1.Rows[e.RowIndex].FindControl("kichco");
        TextBox txtbangtan = (TextBox)GridView1.Rows[e.RowIndex].FindControl("bangtan");
        TextBox txtcamera = (TextBox)GridView1.Rows[e.RowIndex].FindControl("camera");
        TextBox txtxuatxu = (TextBox)GridView1.Rows[e.RowIndex].FindControl("GPRS");
        TextBox txtdactinh = (TextBox)GridView1.Rows[e.RowIndex].FindControl("xuatxu");
        
         Label5.Text = txttensp.Text;
        update(GridView1.DataKeys[e.RowIndex].Value.ToString(), txttensp.Text, System.Convert.ToInt32(txtgia.Text), System.Convert.ToInt16(txtsl.Text), txtkichco.Text, txtbangtan.Text, txtcamera.Text, txtxuatxu.Text, txtdactinh.Text);
        GridView1.EditIndex = -1;
        //Label5.Text = GridView1.DataKeys[e.RowIndex].Value.ToString();
        connect();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        connect();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
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
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      /* if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton del = (LinkButton)e.Row.Cells[1].Controls[0];
            del.OnClientClick = string.Format("return confirm('delete ha nhoc');");
        }*/
    }
}
