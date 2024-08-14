<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qlsp.aspx.cs" Inherits="Default4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
  <table style="color:White;height:100%;background:navy" >
  <tr>
    <td align=left>
        <table width="100%" border="0" >
          <tr>
            <td height="24" align="right">&nbsp;Mã Sản Phẩm :</td>
            <td align="left" >&nbsp;<asp:TextBox ID="TextBox1" runat="server" Width="253px" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
                    EnableTheming="True" ErrorMessage="RequiredFieldValidator" OnDataBinding="Buttonthem_Click"></asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td height="24" align="right">&nbsp;Mã Nhà Sản Xuất :</td>
            <td align="left">&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" Width="258px"></asp:DropDownList></td>
          </tr>
            <tr>
            <td height="24" align="right">&nbsp;Mã Loại :</td>
            <td align="left" >&nbsp;<asp:DropDownList ID="DropDownList2" runat="server" Width="258px"></asp:DropDownList></td>
          </tr>
          <tr>
            <td height="24" align="right">&nbsp;Tên Sản Phẩm :</td>
            <td align="left" >&nbsp;<asp:TextBox ID="TextBox2" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
          <tr>
            <td height="24" align="right">&nbsp;Mô Tả :</td>
            <td align="left" >&nbsp;<asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="253px"></asp:TextBox></td>
          </tr>
          <tr>
            <td height="24" align="right">&nbsp;Giá :
            </td>
            <td align="left" >&nbsp;<asp:TextBox ID="TextBox4" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
          <tr>
            <td align="right">&nbsp;Số Lượng :</td>
            <td height="24" align="left" >&nbsp;<asp:TextBox ID="TextBox5" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right" style="height: 26px">&nbsp;Kích Thước :</td>
            <td align="left" >&nbsp;<asp:TextBox ID="TextBox6" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right">&nbsp;Băng Tần :</td>
            <td height="24" align="left" >&nbsp;<asp:TextBox ID="TextBox7" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right">&nbsp;Camera :</td>
            <td height="24" align="left" >&nbsp;<asp:TextBox ID="TextBox8" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right">&nbsp;GPRS :</td>
            <td height="24" align="left" >&nbsp;<asp:TextBox ID="TextBox9" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right" style="height: 28px">&nbsp;Xuất Xứ:</td>
            <td align="left" style="height: 28px" >&nbsp;<asp:TextBox ID="TextBox10" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
            <tr>
            <td align="right" style="height: 19px">&nbsp;Đặc tính :</td>
            <td align="left" style="height: 19px" >&nbsp;<asp:TextBox ID="TextBox11" runat="server" Width="253px"></asp:TextBox></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td align="left"><asp:Button ID="Buttonthem" runat="server" Text="Thêm" Width="50px" OnClick="Buttonthem_Click" /></td>
          </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td height="197" colspan="2">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="masp"  OnRowDeleting="GridView1_RowDeleting" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="GridView1_RowDataBound" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                    <EditItemTemplate>
                      <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                    </ItemTemplate> 
                </asp:TemplateField>
                <asp:CommandField HeaderText="Delete" ShowDeleteButton="True" ShowHeader="True"  />   
                <asp:TemplateField HeaderText="masp" SortExpression="masp">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("masp") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("masp") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="manhasx" SortExpression="manhasx">
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("manhasx") %>' Width="50px"></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("manhasx") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="maloai" SortExpression="maloai">
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("maloai") %>' Width="45px"></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("maloai") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="tensp" SortExpression="tensp">
                    <EditItemTemplate>
                        &nbsp;<asp:TextBox ID="tensp" runat="server" Text='<%# Bind("tensp") %>' Width="120px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tensp"
                            ErrorMessage="tensp ko dc null" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("tensp") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="gia" SortExpression="gia">
                    <EditItemTemplate>
                        &nbsp;<asp:TextBox ID="gia" runat="server" Text='<%# Bind("gia") %>' Width="50px"></asp:TextBox>&nbsp;
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="gia"
                            ErrorMessage="RangeValidator" MaximumValue="99999999" MinimumValue="100000" SetFocusOnError="True"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("gia") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="soluong" SortExpression="soluong">
                    <EditItemTemplate>
                        <asp:TextBox ID="soluong" runat="server" Text='<%# Bind("soluong") %>' Width="30px"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="soluong"
                            ErrorMessage="RangeValidator" MaximumValue="500" MinimumValue="1" SetFocusOnError="True"
                            Type="Integer"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("soluong") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="kichco" SortExpression="kichco">
                    <EditItemTemplate>
                        <asp:TextBox ID="kichco" runat="server" Text='<%# Bind("kichco") %>' Width="110px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("kichco") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="bangtan" SortExpression="bangtan">
                    <EditItemTemplate>
                        <asp:TextBox ID="bangtan" runat="server" Text='<%# Bind("bangtan") %>' Width="120px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("bangtan") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="camera" SortExpression="camera">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("camera") %>' Width="60px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="camera" runat="server" Text='<%# Bind("camera") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GPRS" SortExpression="GPRS">
                    <EditItemTemplate>
                        <asp:TextBox ID="GPRS" runat="server" Text='<%# Bind("GPRS") %>' Width="60px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("GPRS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="xuatxu" SortExpression="xuatxu">
                    <EditItemTemplate>
                        <asp:TextBox ID="xuatxu" runat="server" Text='<%# Bind("xuatxu") %>' Width="45px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("xuatxu") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>  
        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label></td>
  </tr>
</table>
    </div>
    </form>
</body>
</html>
