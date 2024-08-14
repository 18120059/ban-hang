<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin2.aspx.cs" Inherits="admin2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--Download source code tai Sharecode.vn--%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataKeyNames="masp" BackColor="White" BorderColor="#336666"
                BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal"
                Height="100%" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="false" Width="100%" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="7">
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <Columns>
                    <asp:ButtonField CommandName="xoa" Text="Select"/>
                    <asp:BoundField ItemStyle-HorizontalAlign="Center" DataField="masp" HeaderText="Mã sp" />
                    <asp:BoundField ItemStyle-HorizontalAlign="Center" DataField="tensp" HeaderText="Tên sp" />
                    <asp:BoundField ItemStyle-HorizontalAlign="Center" DataField="tt" HeaderText="TT" />
                    <asp:BoundField ItemStyle-HorizontalAlign="Center" DataField="soluong" HeaderText="Số lượng" />
                    <asp:BoundField ItemStyle-HorizontalAlign="Center" DataField="gia" HeaderText="Giá" />
                </Columns>                
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
    
    </form>
    <div id="test" runat="server"></div>
</body>
</html>
