ARG notebook_version=6.4.7

FROM jupyter/pyspark-notebook:notebook-${notebook_version}

USER root

ARG hadoop_version=3.2.2
RUN curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${hadoop_version}/hadoop-aws-${hadoop_version}.jar -o /usr/local/spark/jars/hadoop-aws-${hadoop_version}.jar

ARG aws_java_sdk_version=1.11.563
RUN curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${aws_java_sdk_version}/aws-java-sdk-bundle-${aws_java_sdk_version}.jar -o /usr/local/spark/jars/aws-java-sdk-bundle-${aws_java_sdk_version}.jar 

# See https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/index.html#Changing_Authentication_Providers
ARG authentication_provider=com.amazonaws.auth.profile.ProfileCredentialsProvider

ENV PYSPARK_SUBMIT_ARGS \ 
        --conf spark.hadoop.fs.s3a.aws.credentials.provider=${authentication_provider} \
        --packages com.amazonaws:aws-java-sdk:${aws_java_sdk_version},org.apache.hadoop:hadoop-aws:${hadoop_version} \
        pyspark-shell
