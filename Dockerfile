FROM alpine:3.15 as builder

RUN apk -U --no-cache add \
    build-base \
    git \
    python3 \
    python3-dev && \
    mkdir /home/mailoney && \
    cd /home/mailoney && \
    git clone https://github.com/phin3has/mailoney.git /home/mailoney && \
    python3 -m venv mailoney-env && \
    . mailoney-env/bin/activate && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade -r requirements.txt

FROM alpine:3.15

ARG VERSION TITLE DESCRIPTION LICENSES URL CREATED REVISION

LABEL org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.authors="armedpot <armedpot@norad.de>" \
      org.opencontainers.image.title="$TITLE" \
      org.opencontainers.image.description="$DESCRIPTION" \
      org.opencontainers.image.licenses="$LICENSES" \
      org.opencontainers.image.url="$URL" \
      org.opencontainers.image.created="$CREATED" \
      org.opencontainers.image.revision="$REVISION"

RUN apk -U --no-cache add \
    python3 && \
    adduser --disabled-password --shell /bin/ash --uid 2000 mailoney

ENV PATH="/home/mailoney/mailoney-env/bin:$PATH"

COPY --from=builder /home/mailoney /home/mailoney

RUN chown -R mailoney:mailoney /home/mailoney

STOPSIGNAL SIGKILL

USER mailoney:mailoney
WORKDIR /home/mailoney

CMD ["python3", "mailoney.py", "-i", "0.0.0.0", "-p", "25", "-s", "mail.tebeke.de", "-t", "schizo_open_relay"]
