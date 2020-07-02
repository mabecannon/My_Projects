using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject
{
    class Pool
    {
        private Location loc;
        private Temperature temp;
        private String name;
        private bool maintained;

        public static int count = 0;//exists globally, but only one exists

        public String Name
        {
            get { return name; }
            set { name = value; }
        }
        public bool Maintained
        {
            get { return maintained; }
            set { maintained = value; }
        }

        public Location Loc
        {
            get { return loc; }
            set { loc = value; }
        }

        public Temperature Temp
        {
            get { return temp; }
            set { temp = value; }
        }

        public Pool()
        {
            Loc = new Location();
            Temp = new Temperature();
            Maintained = false;
            Name = "";
            count++;
        }

        public Pool(Location L, Temperature T, bool m, String name)
        {
            Loc = L;
            Temp = T;
            Maintained = m;
            Name = name;
            count++;
        }

        public override string ToString()
        {
            if(Maintained == true) return String.Format("{0, -40}\n{1, -40}\n{2, -50}\n", Name + ":\n" + Loc.ToString(), Temp.ToString(), "This pool has been maintained!");
            else return String.Format("{0, -40}\n{1, -40}\n{2, -50}\n", Name + ":\n" + Loc.ToString(), Temp.ToString(), "This pool has yet to be maintained!");
        }
    }
}
