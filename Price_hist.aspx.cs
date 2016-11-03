using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string f = DateTime.Now.ToString("dd-MM-yyyy-HH-MM-ss");

        Document doc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
        PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream("D://Report_"+f+".pdf", FileMode.Create));
        doc.Open();

        

        PdfPTable table = new PdfPTable(GridView1.Columns.Count);
        for (int j=0; j < GridView1.Columns.Count; j++)
        { 
            table.AddCell(new Phrase(GridView1.Columns[j].HeaderText));
        }

        table.HeaderRows = 1;

        for(int i=0; i < GridView1.Rows.Count; i++)
        {
            for(int K=0; K < GridView1.Columns.Count; K++ )
            {
                table.AddCell(new Phrase(GridView1.Rows[i].Cells[K].Text));   
            }
        }

        Paragraph paragraph = new Paragraph("                ****************Report*******************");
        doc.Add(paragraph);
        doc.Add(table);
        doc.Close();
    }


}



























