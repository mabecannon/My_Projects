using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject
{
    class Location
    {
        private int x;
        private int y;

        public int X
        {
            get { return x; }
            set { x = value; }
        }

        public Location()
        {
            X = 0;
            Y = 0;
        }

        public Location(int x, int y)
        {
            X = x;
            Y = y;
        }

        public int Y
        {
            get { return y; }
            set { y = value; }
        }

        public override string ToString()
        {
            return "X: " + X + " Y: " + Y + "\n";
        }
    }
}
