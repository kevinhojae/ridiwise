# ridiwise

리디북스에서 밑줄 친 하이라이트를 Readwise로 자동 동기화하는 도구입니다.

## 이게 뭔가요?

리디북스에서 책을 읽으면서 밑줄 친 내용들, 나중에 다시 보고 싶지 않으셨나요?

**ridiwise**는 리디북스의 하이라이트(밑줄)를 [Readwise](https://readwise.io)로 자동으로 옮겨주는 도구입니다.

Readwise에 모아두면 매일 복습 이메일을 받거나, Notion/Obsidian 등으로 내보내기도 할 수 있어요.

## 시작하기 전에 준비할 것

1. **Readwise 계정** - [readwise.io](https://readwise.io)에서 가입
2. **Readwise API 토큰** - [여기서 발급](https://readwise.io/access_token)
3. **리디북스 계정 정보** - 아이디와 비밀번호

## 설치 방법

### 방법 1: Docker 사용 (권장)

Docker가 설치되어 있다면 별도 설치 없이 바로 사용할 수 있습니다.

```bash
docker run --rm -it bskim45/ridiwise --help
```

### 방법 2: pip으로 설치

Python 3.10 이상이 필요합니다.

```bash
# 1. playwright 설치 (브라우저 자동화 도구)
pip install playwright
playwright install chromium

# 2. ridiwise 설치
pip install git+https://github.com/bskim45/ridiwise.git
```

## 사용 방법

### 모든 책의 하이라이트 동기화하기

리디북스에 있는 모든 책의 하이라이트를 Readwise로 옮깁니다.

**Docker 사용 시:**

```bash
docker run --rm -it \
    -e READWISE_TOKEN=여기에_readwise_토큰 \
    -e RIDI_USER_ID=여기에_리디북스_아이디 \
    -e RIDI_PASSWORD=여기에_리디북스_비밀번호 \
    bskim45/ridiwise sync ridibooks readwise
```

**직접 설치한 경우:**

```bash
ridiwise sync ridibooks readwise \
    --readwise-token 여기에_readwise_토큰 \
    --user-id 여기에_리디북스_아이디 \
    --password 여기에_리디북스_비밀번호
```

### 특정 책만 동기화하기

특정 책의 하이라이트만 옮기고 싶다면 `--book-id` 옵션을 사용하세요.

**책 ID 찾는 방법:**
1. 리디북스 웹사이트에서 해당 책의 독서노트 페이지로 이동
2. URL에서 숫자를 확인: `https://ridibooks.com/reading-note/detail/1008004919`
3. 이 예시에서 책 ID는 `1008004919`

```bash
# Docker 사용 시
docker run --rm -it \
    -e READWISE_TOKEN=여기에_readwise_토큰 \
    -e RIDI_USER_ID=여기에_리디북스_아이디 \
    -e RIDI_PASSWORD=여기에_리디북스_비밀번호 \
    bskim45/ridiwise sync ridibooks readwise --book-id 1008004919

# 직접 설치한 경우
ridiwise sync ridibooks readwise \
    --readwise-token 여기에_readwise_토큰 \
    --user-id 여기에_리디북스_아이디 \
    --password 여기에_리디북스_비밀번호 \
    --book-id 1008004919
```

**여러 책을 동시에 동기화하려면:**

```bash
ridiwise sync ridibooks readwise \
    --readwise-token 토큰 \
    --user-id 아이디 \
    --password 비밀번호 \
    --book-id 1008004919 \
    --book-id 1234567890
```

## 환경 변수로 설정하기

매번 토큰과 비밀번호를 입력하기 번거롭다면, `.env` 파일을 만들어 저장해두세요.

`.env` 파일 예시:

```
READWISE_TOKEN=여기에_readwise_토큰
RIDI_USER_ID=여기에_리디북스_아이디
RIDI_PASSWORD=여기에_리디북스_비밀번호
```

이후에는 간단하게 실행할 수 있습니다:

```bash
ridiwise sync ridibooks readwise
```

## 옵션 설명

| 옵션 | 환경 변수 | 설명 |
|------|----------|------|
| `--readwise-token` | `READWISE_TOKEN` | Readwise API 토큰 |
| `--user-id` | `RIDI_USER_ID` | 리디북스 아이디 |
| `--password` | `RIDI_PASSWORD` | 리디북스 비밀번호 |
| `--book-id` | - | 특정 책 ID (여러 번 사용 가능) |
| `--tags` | - | 하이라이트에 붙일 태그 |
| `--no-headless-mode` | `HEADLESS_MODE` | 브라우저 창을 보이게 실행 (디버깅용) |

## 문제가 생겼을 때

- `--no-headless-mode` 옵션을 추가하면 브라우저 창이 보이면서 실행됩니다. 어디서 문제가 생기는지 확인할 수 있어요.
- 로그인 관련 문제는 리디북스 아이디/비밀번호가 정확한지 확인해주세요.

## 라이선스

MIT License - 자유롭게 사용하실 수 있습니다.
