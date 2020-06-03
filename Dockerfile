FROM node:alpine AS ui-build

WORKDIR /ui
COPY frontend/ /ui/
RUN yarn install --network-concurrency=25 && yarn build && rm -rf node_modules

FROM python:3.7-slim-buster
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY backend/ /app
COPY --from=ui-build /ui/dist/index.html /app/linkalong/templates/index.html
COPY --from=ui-build /ui/dist/css /app/linkalong/static/css
COPY --from=ui-build /ui/dist/js /app/linkalong/static/js

RUN python3.7 -m pip install --upgrade --no-cache-dir pip poetry && \
    poetry export -f requirements.txt > requirements.txt && \
    python3.7 -m pip install -r requirements.txt && \
    sed -i -e 's|/js/|/static/js/|g' /app/linkalong/templates/index.html && \
    sed -i -e 's|/css/|/static/css/|g' /app/linkalong/templates/index.html
EXPOSE 8000
CMD ["uvicorn", "linkalong.main:app", "--host", "0.0.0.0"]
