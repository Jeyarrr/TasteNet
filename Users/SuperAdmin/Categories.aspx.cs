using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSampleData();
            }
        }
        private void LoadSampleData()
        {
            var categories = new List<object>
            {
                new { ID = "CAT-001", CategoryName = "Sizzling Specials", Description = "Premium sizzling plate meals featuring authentic Filipino sisig and other hot plate dishes", ItemCount = 4 },
                new { ID = "CAT-002", CategoryName = "Silog Meals", Description = "Classic Filipino breakfast combinations with rice, egg, and your choice of protein", ItemCount = 9 },
                new { ID = "CAT-003", CategoryName = "Special Meals", Description = "Comfort food and traditional Filipino favorites including goto and arrozcaldo", ItemCount = 4 }
            };

            rptCategories.DataSource = categories;
            rptCategories.DataBind();
        }
    }
}