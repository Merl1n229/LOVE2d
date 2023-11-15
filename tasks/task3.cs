using System;
using System.IO;

class Program
{
    static void Main()
    {
        string[] input = File.ReadAllLines("input3.txt");
        int n = int.Parse(input[0]);

        double[,] matrix = new double[n, n + 1];

        for (int i = 0; i < n; i++)
        {
            string[] coefficients = input[i + 1].Split();
            for (int j = 0; j <= n; j++)
            {
                matrix[i, j] = double.Parse(coefficients[j]);
            }
        }

        double[] solution = SolveSystem(matrix, n);

        File.WriteAllText("output3.txt", string.Join(" ", solution));
    }

    static double[] SolveSystem(double[,] matrix, int n)
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = i + 1; j < n; j++)
            {
                double ratio = matrix[j, i] / matrix[i, i];
                for (int k = i; k <= n; k++)
                {
                    matrix[j, k] -= ratio * matrix[i, k];
                }
            }
        }

        double[] solution = new double[n];
        for (int i = n - 1; i >= 0; i--)
        {
            double sum = 0;
            for (int j = i + 1; j < n; j++)
            {
                sum += matrix[i, j] * solution[j];
            }
            solution[i] = (matrix[i, n] - sum) / matrix[i, i];
        }

        return solution;
    }
}