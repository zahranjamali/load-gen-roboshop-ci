FROM python:3.9 as build

# Some default values

WORKDIR /load

COPY requirements.txt /load/

RUN pip install -r requirements.txt

FROM gcr.io/distroless/python3

WORKDIR /load

COPY --from=build /load/ /load/

COPY entrypoint.sh /load/
COPY robot-shop.py /load/

ENV HOST="http://localhost:8080/" \
    SILENT=0 \
    NUM_CLIENTS=1 \
    ERROR=0 \
    RUN_TIME=0

CMD ["./entrypoint.sh"]

