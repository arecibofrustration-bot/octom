// Supabase client initializer
// To deploy: Set SUPABASE_URL and SUPABASE_ANON_KEY as environment variables
// or replace the placeholders below with your Supabase project credentials.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const supabaseUrl = "https://bblysgmnhvpwyqonryei.supabase.co";
const supabaseAnonKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJibHlzZ21uaHZwd3lxb25yeWVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMxOTk1NTQsImV4cCI6MjEwODc3NTU1NH0.dqv-96vsDZkyruaFzjaucWXsYRoYQUw7Ckv9GjfrYw0";

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
