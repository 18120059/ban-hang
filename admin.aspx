<%@ Page Language="C#" MasterPageFile="~/MasterPage_admin.master" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript">
    function xacnhan()
    {
        return confirm("Co muon xoa hay khong?");
    }
</script>

<form id="form1" runat="server">
    <div>
        &nbsp;
        <asp:GridView ID="GridView1" runat="server" DataKeyNames="masp" BackColor="White" BorderColor="#336666"
                BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal"
                Height="100%" Width="100%" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="7">
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <Columns>
                    <asp:CommandField HeaderText="Sửa" ShowEditButton="True"/>
                    <asp:TemplateField>
                        
                        <ItemTemplate>
                            <asp:Label ID="masp" Visible="false" Text=<%#DataBinder.Eval(Container.DataItem,"masp") %> runat="server"></asp:Label>
                            <asp:CheckBox ID="check" runat="server" /> 
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
                                
                <RowStyle HorizontalAlign="Center" BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        </asp:GridView>    
        <center><asp:Button ID="cmdXoa" runat="server" OnClientClick="return xacnhan()" OnClick="cmdXoa_click" Text="Delete"/></center>
    </div>
    <div id="test" style="text-align:center;color:White">
        <% 
            if(Session["err_delete"]!=null)
                Response.Write("Sản phẩm bạn xoá đã có trong danh mục hàng được đặt mua");
            Session["err_delete"] = null;
        %>
    </div>
    </form>
    
</asp:Content>

