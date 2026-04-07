import React, { useState, useEffect, useMemo } from 'react';
import { createClient } from '@supabase/supabase-js';
import { 
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, 
  ResponsiveContainer, BarChart, Bar, Cell 
} from 'recharts';
import { 
  Wallet, TrendingUp, TrendingDown, PlusCircle, 
  LogOut, Settings, Database, AlertCircle, Loader2 
} from 'lucide-react';

/**
 * CONFIGURATION & UTILS
 */
const STORAGE_KEYS = {
  URL: 'sb_url',
  KEY: 'sb_key'
};

// Simple formatter for currency
const formatCurrency = (val) => 
  new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(val);

/**
 * MAIN COMPONENT
 */
export default function AccountingApp() {
  const [config, setConfig] = useState({
    url: localStorage.getItem(STORAGE_KEYS.URL) || '',
    key: localStorage.getItem(STORAGE_KEYS.KEY) || ''
  });
  const [supabase, setSupabase] = useState(null);
  const [isReady, setIsReady] = useState(false);

  // Initialize Supabase client when config changes
  useEffect(() => {
    if (config.url && config.key) {
      try {
        const client = createClient(config.url, config.key);
        setSupabase(client);
        setIsReady(true);
      } catch (err) {
        console.error("Initialization error:", err);
      }
    }
  }, [config]);

  const saveCredentials = (url, key) => {
    localStorage.setItem(STORAGE_KEYS.URL, url);
    localStorage.setItem(STORAGE_KEYS.KEY, key);
    setConfig({ url, key });
  };

  const disconnect = () => {
    localStorage.removeItem(STORAGE_KEYS.URL);
    localStorage.removeItem(STORAGE_KEYS.KEY);
    window.location.reload();
  };

  if (!isReady) {
    return <SetupGate onConnect={saveCredentials} />;
  }

  return <DashboardView supabase={supabase} onDisconnect={disconnect} />;
}

/**
 * SUB-COMPONENT: SETUP GATE
 */
function SetupGate({ onConnect }) {
  const handleSubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    onConnect(formData.get('url'), formData.get('key'));
  };

  return (
    <div className="min-h-screen bg-slate-950 flex items-center justify-center p-4">
      <div className="w-full max-w-md bg-white rounded-3xl shadow-2xl p-8 border border-slate-200">
        <div className="flex items-center gap-3 mb-6">
          <div className="p-3 bg-indigo-100 rounded-2xl text-indigo-600">
            <Database size={24} />
          </div>
          <h2 className="text-2xl font-bold text-slate-800">Database Setup</h2>
        </div>
        
        <p className="text-slate-500 mb-8 text-sm leading-relaxed">
          Connect your <strong>Supabase</strong> project to begin. Your credentials are stored 
          strictly in your browser's local cache.
        </p>
        
        <form onSubmit={handleSubmit} className="space-y-5">
          <div className="space-y-1">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider ml-1">Project URL</label>
            <input 
              name="url" type="url" required placeholder="https://your-id.supabase.co"
              className="w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-500 outline-none transition-all text-sm"
            />
          </div>
          <div className="space-y-1">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider ml-1">Anon Key</label>
            <input 
              name="key" type="password" required placeholder="public-anon-key..."
              className="w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-500 outline-none transition-all text-sm"
            />
          </div>
          <button 
            type="submit" 
            className="w-full bg-slate-900 hover:bg-slate-800 text-white font-semibold py-4 rounded-xl transition-all shadow-lg active:scale-[0.98]"
          >
            Initialize Dashboard
          </button>
        </form>
      </div>
    </div>
  );
}

/**
 * SUB-COMPONENT: ACTUAL DASHBOARD UI
 */
function DashboardView({ supabase, onDisconnect }) {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      const { data: transactions, error } = await supabase
        .from('transactions')
        .select('*')
        .order('date', { ascending: true });

      if (error) setError(error.message);
      else setData(transactions || []);
      setLoading(false);
    };

    fetchData();
  }, [supabase]);

  // Derived Statistics
  const totals = useMemo(() => {
    return data.reduce((acc, curr) => {
      const amt = parseFloat(curr.amount);
      if (amt > 0) acc.income += amt;
      else acc.expense += Math.abs(amt);
      acc.balance += amt;
      return acc;
    }, { income: 0, expense: 0, balance: 0 });
  }, [data]);

  if (loading) return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-4 text-slate-400 bg-slate-50">
      <Loader2 className="animate-spin text-indigo-600" size={40} />
      <span className="font-medium animate-pulse">Syncing with Supabase...</span>
    </div>
  );

  return (
    <div className="min-h-screen bg-[#F8FAFC] text-slate-900 font-sans antialiased">
      {/* Top Navbar */}
      <nav className="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-slate-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex justify-between items-center">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center text-white font-bold">A</div>
            <span className="font-bold tracking-tight text-lg">LedgerFlow</span>
          </div>
          <div className="flex items-center gap-4">
            <button className="hidden md:flex items-center gap-2 bg-slate-900 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-slate-800 transition-colors shadow-sm">
              <PlusCircle size={16} /> New Transaction
            </button>
            <div className="h-6 w-px bg-slate-200 mx-2" />
            <button onClick={onDisconnect} className="p-2 text-slate-400 hover:text-red-500 transition-colors" title="Disconnect DB">
              <LogOut size={20} />
            </button>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto p-6 space-y-8">
        {error && (
          <div className="bg-red-50 border border-red-100 text-red-600 p-4 rounded-xl flex items-center gap-3">
            <AlertCircle size={20} />
            <span className="text-sm font-medium">Database Error: {error}</span>
          </div>
        )}

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <StatCard title="Total Balance" value={totals.balance} icon={<Wallet />} color="indigo" />
          <StatCard title="Total Income" value={totals.income} icon={<TrendingUp />} color="emerald" />
          <StatCard title="Total Expenses" value={totals.expense} icon={<TrendingDown />} color="pink" />
        </div>

        {/* Charts Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2 bg-white p-6 rounded-3xl border border-slate-200 shadow-sm">
            <div className="flex justify-between items-center mb-6">
              <h3 className="font-bold text-slate-800">Cash Flow History</h3>
              <select className="text-xs font-semibold bg-slate-50 border-none rounded-lg p-2 outline-none text-slate-500">
                <option>Last 30 Days</option>
              </select>
            </div>
            <div className="h-[300px]">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={data}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#F1F5F9" />
                  <XAxis dataKey="date" fontSize={10} axisLine={false} tickLine={false} tick={{fill: '#94A3B8'}} />
                  <YAxis hide />
                  <Tooltip 
                    contentStyle={{borderRadius: '16px', border: 'none', boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1)'}} 
                    formatter={(v) => formatCurrency(v)}
                  />
                  <Line type="monotone" dataKey="amount" stroke="#4F46E5" strokeWidth={4} dot={{r: 4, fill: '#4F46E5'}} activeDot={{r: 6, strokeWidth: 0}} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>

          <div className="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm">
            <h3 className="font-bold text-slate-800 mb-6">Category Breakdown</h3>
            <div className="h-[300px]">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.slice(-5)}>
                  <Bar dataKey="amount" radius={[6, 6, 0, 0]}>
                    {data.map((entry, index) => (
                      <Cell key={index} fill={entry.amount > 0 ? '#10B981' : '#F472B6'} />
                    ))}
                  </Bar>
                  <Tooltip cursor={{fill: 'transparent'}} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* List */}
        <div className="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">
          <div className="p-6 border-b border-slate-100 flex justify-between items-center">
            <h3 className="font-bold text-slate-800">Transaction History</h3>
            <button className="text-sm font-semibold text-indigo-600 hover:text-indigo-700">View All</button>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead>
                <tr className="bg-slate-50/50 text-slate-400 text-[10px] uppercase tracking-widest font-bold">
                  <th className="px-6 py-4">Transaction</th>
                  <th className="px-6 py-4">Category</th>
                  <th className="px-6 py-4">Date</th>
                  <th className="px-6 py-4 text-right">Amount</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-50">
                {data.length === 0 ? (
                  <tr><td colSpan="4" className="text-center py-12 text-slate-400 italic">No data found in Supabase.</td></tr>
                ) : (
                  data.map((item) => (
                    <tr key={item.id} className="hover:bg-slate-50/80 transition-colors group">
                      <td className="px-6 py-4">
                        <p className="font-semibold text-slate-700 group-hover:text-indigo-600 transition-colors">{item.description}</p>
                      </td>
                      <td className="px-6 py-4">
                        <span className="px-3 py-1 rounded-full bg-slate-100 text-slate-500 text-xs font-medium uppercase tracking-tight">
                          {item.category}
                        </span>
                      </td>
                      <td className="px-6 py-4 text-slate-400 text-sm">{item.date}</td>
                      <td className={`px-6 py-4 text-right font-bold ${item.amount < 0 ? 'text-pink-500' : 'text-emerald-500'}`}>
                        {item.amount < 0 ? '-' : '+'}{formatCurrency(Math.abs(item.amount))}
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
  );
}

function StatCard({ title, value, icon, color }) {
  const colors = {
    indigo: "bg-indigo-50 text-indigo-600",
    emerald: "bg-emerald-50 text-emerald-600",
    pink: "bg-pink-50 text-pink-600"
  };

  return (
    <div className="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm flex items-center gap-5 hover:shadow-md transition-shadow">
      <div className={`p-4 rounded-2xl ${colors[color]}`}>
        {React.cloneElement(icon, { size: 24 })}
      </div>
      <div>
        <p className="text-sm font-semibold text-slate-400 mb-0.5">{title}</p>
        <p className="text-2xl font-bold tracking-tight text-slate-800">{formatCurrency(value)}</p>
      </div>
    </div>
  );
}
