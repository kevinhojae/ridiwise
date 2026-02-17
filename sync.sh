#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo ".env 파일이 없습니다."
  exit 1
fi

# .env 로드
set -a
source "$ENV_FILE"
set +a

# 인자 파싱
BOOK_ID=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --book-id)
      BOOK_ID="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

# 기본 명령 배열
CMD=(
  ridiwise sync ridibooks readwise
  --readwise-token "$READWISE_TOKEN"
  --user-id "$RIDI_ID"
  --password "$RIDI_PASSWORD"
  --no-headless-mode
)

# book-id 있으면 추가
if [[ -n "$BOOK_ID" ]]; then
  CMD+=(--book-id "$BOOK_ID")
  echo "특정 책만 동기화: $BOOK_ID"
else
  echo "전체 책 동기화"
fi

# 실행
"${CMD[@]}"
