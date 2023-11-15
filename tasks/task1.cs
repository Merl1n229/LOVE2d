using System;
using System.IO;

class Program
{
    static void Main()
    {
        string[] input = File.ReadAllLines("input1.TXT");
        string[] wh = input[0].Split();
        int w = int.Parse(wh[0]);
        int h = int.Parse(wh[1]);
        int n = int.Parse(input[1]);

        int[,] canvas = new int[h, w];

        for (int i = 2; i < 2 + n; i++)
        {
            string[] rectangle = input[i].Split();
            int x1 = int.Parse(rectangle[0]);
            int y1 = int.Parse(rectangle[1]);
            int x2 = int.Parse(rectangle[2]);
            int y2 = int.Parse(rectangle[3]);

            for (int j = y1; j < y2; j++)
            {
                for (int k = x1; k < x2; k++)
                {
                    canvas[j, k] = 1;
                }
            }
        }

        int unpaintedArea = 0;
        for (int i = 0; i < h; i++)
        {
            for (int j = 0; j < w; j++)
            {
                if (canvas[i, j] == 0)
                {
                    unpaintedArea++;
                }
            }
        }

        File.WriteAllText("output1.TXT", unpaintedArea.ToString());
    }
}
