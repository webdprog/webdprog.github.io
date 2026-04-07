import { useState } from "react";

export default function ConfigForm({ onSave }) {
  const [url, setUrl] = useState("");
  const [key, setKey] = useState("");

  const handleSubmit = () => {
    localStorage.setItem("sb_url", url);
    localStorage.setItem("sb_key", key);
    onSave();
  };

  return (
    <div className="config">
      <h2>Connect Supabase</h2>
      <input placeholder="Supabase URL" onChange={e => setUrl(e.target.value)} />
      <input placeholder="Anon Key" onChange={e => setKey(e.target.value)} />
      <button onClick={handleSubmit}>Save</button>
    </div>
  );
}