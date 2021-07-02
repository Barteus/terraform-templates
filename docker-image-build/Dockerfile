FROM public.ecr.aws/lambda/python:3.8
COPY code/requirements.txt .
RUN pip3 install -r requirements.txt
COPY code/src/lambda.py  .
RUN chmod +xr lambda.py
CMD [ "lambda.lambda_handler"]
