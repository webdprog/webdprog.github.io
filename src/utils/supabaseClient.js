import { createClient } from '@supabase/supabase-js';

export const getSupabase = () => {
  const url = localStorage.getItem("sb_url");
  const key = localStorage.getItem("sb_key");

  if (!url || !key) return null;

  return createClient(url, key);
};