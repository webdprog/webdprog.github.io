import { useEffect, useState, lazy, Suspense } from "react";
import { getSupabase } from "../utils/supabaseClient";

const ChartView = lazy(() => import("./ChartView"));

export default function Dashboard() {
  const [data, setData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const supabase = getSupabase();
      if (!supabase) return;

      const { data } = await supabase.from("transactions").select("*");
      setData(data || []);
    };

    fetchData();
  }, []);

  return (
    <div>
      <h1>Accounting Dashboard</h1>

      <Suspense fallback={<p>Loading chart...</p>}>
        <ChartView data={data} />
      </Suspense>
    </div>
  );
}