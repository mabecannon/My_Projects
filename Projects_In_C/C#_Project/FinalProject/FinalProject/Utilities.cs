using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject
{
    class Utilities
    {
        public static double DistanceFormula(int x1, int y1, int x2, int y2)
        {
            return Math.Sqrt(Math.Pow((x1 - x2), 2) + Math.Pow((y1 - y2), 2));
        }

        public static int GetClosestPool(Pool[] p, int x, int y)
        {
            int iter = -1;
            double closest = Double.MaxValue;
            for(int i = 0; i < p.Length; i++)
            {
                if(p[i].Maintained == false && DistanceFormula(x, y, p[i].Loc.X, p[i].Loc.Y) < closest)
                {
                    closest = DistanceFormula(x, y, p[i].Loc.X, p[i].Loc.Y);
                    iter = i;
                }
            }//finding the index and distance of the furthest pool
            return iter;//the closest pool index from where we are
        }//if -1 is returned, all pools are maintained
    }
}
