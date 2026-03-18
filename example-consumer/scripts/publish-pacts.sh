#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT_DIR"

RUBY_LAUNCHER=$(ls node_modules/@pact-foundation/pact-cli-linux-*/standalone/*/pact/lib/ruby/bin/ruby 2>/dev/null | head -n 1 || true)
if [ -n "$RUBY_LAUNCHER" ] && [ -f "$RUBY_LAUNCHER" ]; then
  if ! grep -q 'ruby_environment" | sed -E' "$RUBY_LAUNCHER"; then
    cat > "$RUBY_LAUNCHER" <<'EOF'
#!/usr/bin/env sh
set -e
ROOT=$(dirname "$0")
ROOT=$(cd "$ROOT/.." && pwd)
eval "$("$ROOT/bin/ruby_environment" | sed -E 's/^([A-Z_][A-Z0-9_]*)=(.*)$/\1="\2"/')"
exec "$ROOT/bin.real/ruby" "$@"
EOF
    chmod +x "$RUBY_LAUNCHER"
  fi
fi

exec npx pact-broker publish --auto-detect-version-properties ./pacts "$@"
