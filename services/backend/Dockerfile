FROM python:3.14-slim-bookworm AS builder

ARG EXTRA_GROUPS=""

RUN mkdir /app
WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.in-project true \
    && poetry install --no-root --only main ${EXTRA_GROUPS:+--only $EXTRA_GROUPS} \
    --no-interaction --no-ansi \
    && rm -rf $(poetry config cache-dir)/{cache,artifacts}

FROM python:3.14-slim-bookworm AS runtime

COPY --from=builder /app/.venv /app/.venv

WORKDIR /app

ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONPATH=.

RUN unset PYTHONHOME

COPY ./src ./src
COPY ./config.json ./

ENTRYPOINT ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "5000"]
