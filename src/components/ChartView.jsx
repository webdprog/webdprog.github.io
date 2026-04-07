import {
  Chart as ChartJS,
  BarElement,
  CategoryScale,
  LinearScale
} from "chart.js";
import { Bar } from "react-chartjs-2";

ChartJS.register(BarElement, CategoryScale, LinearScale);

export default function ChartView({ data }) {

  const grouped = {};

  data.forEach(item => {
    const date = new Date(item.created_at);
    const key = `${date.getFullYear()}-${date.getMonth()+1}`;

    grouped[key] = (grouped[key] || 0) + Number(item.amount);
  });

  const labels = Object.keys(grouped);
  const values = Object.values(grouped);

  const chartData = {
    labels,
    datasets: [
      {
        label: "Monthly Spending",
        data: values
      }
    ]
  };

  return <Bar data={chartData} />;
}