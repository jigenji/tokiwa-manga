# トキワマンガ（検証用サービス）。app.tar.gz.part-* を組み立てて動かす（画像・カタログは取り込み済み）
FROM node:22-bookworm-slim
WORKDIR /app
COPY app.tar.gz.part-* /tmp/parts/
RUN cat /tmp/parts/app.tar.gz.part-* | tar xz -C /app && rm -rf /tmp/parts && mkdir -p /data
ENV NODE_ENV=production PORT=8080 DATA_DIR=/data MEDIA_DIR=/app/service/media CATALOG_SEED=/app/catalog/tokiwa.db INDEXING=off
WORKDIR /app/service
EXPOSE 8080
CMD ["node", "--disable-warning=ExperimentalWarning", "src/server.js"]
