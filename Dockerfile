FROM python:3.9.9-slim-bullseye
LABEL maintainer="byan"

ENV PYTHONUNBUFFERED 1

COPY . /code
WORKDIR /code
EXPOSE 8000

ARG DEV=false

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN chmod +x scripts/bootstrap.sh && \
    scripts/bootstrap.sh && \
    pip install -r /code/requirements/requirements.txt && \
    if [ $DEV = "true" ]; \
    then \
        echo "Installing dev requirements" && \
        pip install -r /code/requirements/requirements-dev.txt; \
    fi && \
    rm -rf /code/requirements && \
    adduser \
      --disabled-password \
      --no-create-home \
      django-user


USER django-user
