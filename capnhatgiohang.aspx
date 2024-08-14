<%@ Page Language="C#" %>

<% 
    Response.ContentType = "text/html;charset=utf-8";
    //Response.Write(Request.Form["cmdCapnhat"].ToString());
    if (Session["giohang"] != null)
        if (Request.Form["cmdCapnhat"] != null && !Session["giohang"].ToString().Equals("0"))
        {
            string maspsua=Request.Form["maspsua"].ToString();
			string slsua=Request.Form["slsua"].ToString();
			string xoa=Request.Form["xoasp"].ToString();
            Response.Write(xoa.ToString());
            int len1 = Session["sanpham"].ToString().Split(';').Length - 1;
            string[] mangsp = Session["sanpham"].ToString().Split(';');
            string[] mangsl = Session["sl"].ToString().Split(';');
            if (maspsua != "")
            {
                string[] tam_sp = maspsua.ToString().Split(';');
                string[] tam_sl = slsua.ToString().Split(';');
                int len2 = tam_sp.Length - 1;
                maspsua = "";
                slsua = "";
                for (int i = 0; i < len2; i++)
                {
                    string ma = tam_sp[i];
                    for(int j=0;j<len1;j++)
                        if (ma.Equals(mangsp[j]))
                        {
                            mangsl[j] = tam_sl[i];
                            break;
                        }
                }
                for (int i = 0; i < len1; i++)
                {
                    maspsua += mangsp[i] + ";";
                    slsua += mangsl[i] + ";";
                }
                Session["sanpham"] = maspsua;
                Session["sl"] = slsua;
            }
            if (xoa != "")
            {
                string[] tam_xoa = xoa.ToString().Split(';');
                int len3 = tam_xoa.Length;
                for (int i = 0; i < len3; i++)//duyet qua cac san pham can xoa
                {
                    string ma = tam_xoa[i];
                    //Response.Write(ma);
                    maspsua = "";
                    slsua = "";
                    for (int j = 0; j < len1; j++)
                    {
                        //Response.Write(mangsp[j]);
                        if (ma.Equals(mangsp[j]))//neu tim thay san pham do trong gio hang thi xoa san pham trong gio hang tuong ung bang cach chi luu lai cac san pham khong xoa vao bien sau moi lan duyet
                        {
                            int dem = int.Parse(Session["giohang"].ToString());
                            dem--;
                            Session["giohang"] = dem.ToString();
                            continue;
                        }
                        maspsua += mangsp[j] + ";";
                        slsua += mangsl[j] + ";";
                    }
                    //cap nhat lai danh sach san pham moi sau moi lan xoa
                    mangsp = maspsua.ToString().Split(';');
                    mangsl = slsua.ToString().Split(';');
                    len1 = mangsp.Length - 1;
                }
                Session["sanpham"] = maspsua;
                Session["sl"] = slsua;
                //Response.Write(Session["sanpham"].ToString());
                //Response.Write(Session["sl"].ToString());
                //Response.Write(Session["giohang"].ToString());
            }
            Response.Redirect("giohang.aspx");
        }
        else if (Session["sanpham"] != null && Session["sl"] != null)
        {
            string masp = Request.QueryString["masp"].ToString();
            string soluong = Request.QueryString["soluong"].ToString();
            int sohang = int.Parse(Session["giohang"].ToString());
            bool flag = false;//kiem tra san pham them vao da co trong danh sach chua
            if (sohang == 0)
            {
                sohang++;
                Session["giohang"] = sohang.ToString();
                Session["sanpham"] = masp + ";";
                Session["sl"] = soluong + ";";
            }
            else
            {
                int len = Session["sanpham"].ToString().Split(';').Length - 1;
                string[] mangsp = Session["sanpham"].ToString().Split(';');
                string[] mangsl = Session["sl"].ToString().Split(';');
                Session["sanpham"] = "";
                Session["sl"] = "";
                string tam1 = "";//bien luu danh sach san pham sau khi da duoc them
                string tam2 = "";//bien luu so luong tuong ung cua tung san pham
                for (int i = 0; i < len; i++)
                {
                    if (masp.Equals(mangsp[i]))//da co san pham trong gio hang
                    {
                        int sl = int.Parse(mangsl[i].ToString());//lay so luong cu cong them so luong dat mua
                        sl += int.Parse(soluong.ToString());
                        mangsl[i] = sl.ToString();
                        flag = true;
                    }
                    //dua vao bien luu danh sach san pham dat mua
                    tam1 += mangsp[i] + ";";
                    tam2 += mangsl[i] + ";";
                }
                if (!flag)//san pham them vao chua co trong danh sach->tang so luong san pham len va them vao danh sach san pham
                {
                    sohang++;
                    Session["giohang"] = sohang.ToString();
                    tam1 += masp + ";";
                    tam2 += soluong + ";";
                }
                Session["sanpham"] = tam1;
                Session["sl"] = tam2;
            }
            //Response.Write(Session["sanpham"].ToString());
            //Response.Write(Session["sl"].ToString());
            string result = "";
            result = Session["giohang"].ToString();
            Response.Write(result);
        }
        
            
    
%>
