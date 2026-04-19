#!/bin/bash
PAGES=(
  "index.html"
  "blog.html"
  "changelog.html"
  "comparison.html"
  "odoo-gmail-plugin-alternative.html"
  "pricing.html"
  "privacy.html"
  "user-guide.html"
  "blog/odoo-api-key-setup.html"
  "blog/odoo-gmail-domain-configuration.html"
)
LANGS=("" "de" "es" "fr" "it" "nl" "pl" "pt")
BASE_DIR="odoo-integration-gmail-docs"

for lang in "${LANGS[@]}"; do
  for page in "${PAGES[@]}"; do
    lang_prefix="${lang:+$lang/}"
    src_path="$BASE_DIR/$lang_prefix$page"
    if [ "$page" = "index.html" ]; then
      dest_path="/gmail-odoo/$lang_prefix"
    else
      dest_path="/gmail-odoo/$lang_prefix$page"
    fi
    mkdir -p "$(dirname "$src_path")"
    cat > "$src_path" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0;url=$dest_path">
    <link rel="canonical" href="https://integrationnode.com$dest_path">
    <title>Redirecting...</title>
</head>
<body>
    <p>Redirecting to <a href="$dest_path">$dest_path</a>...</p>
</body>
</html>
EOF
  done
done
echo "Done: $(find $BASE_DIR -name '*.html' | wc -l) redirect pages created"
