import { useState, useEffect } from "react";
import ConfigForm from "./components/ConfigForm";
import Dashboard from "./components/Dashboard";

function App() {
  const [configured, setConfigured] = useState(false);

  useEffect(() => {
    const url = localStorage.getItem("sb_url");
    const key = localStorage.getItem("sb_key");
    if (url && key) setConfigured(true);
  }, []);

  return (
    <div>
      {!configured ? (
        <ConfigForm onSave={() => setConfigured(true)} />
      ) : (
        <Dashboard />
      )}
    </div>
  );
}

export default App;