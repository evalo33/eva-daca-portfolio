from supabase import create_client

url = "https://elbzbnhyropsfgqwfghz.supabase.co"
key = "sb_publishable_CXtCKlVjk5Hn8IwwPbiNbg_xKBFvnl_"

supabase = create_client(url, key)

response = supabase.table("test_sales").select("*").execute()

print(f"Leitud ridu: {len(response.data)}")
for row in response.data:
    print(row)