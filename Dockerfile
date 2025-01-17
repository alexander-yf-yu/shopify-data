FROM python

# allow initial logs to be written out
ENV PYTHONUNBUFFERED True

# port for container to expose
ENV PORT 8080

# location for uploaded images (set to flask '/static')
ENV IMAGE_DIR static

WORKDIR /ImageEngine

COPY . .

RUN mkdir -p $IMAGE_DIR
RUN pip3 install -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 'app:create_app()'
