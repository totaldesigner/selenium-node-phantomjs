FROM selenium/node-base:3.0.1-aluminum
MAINTAINER totaldesigner <totaldesigner@gmail.com>

USER root

#==============
# PhantomJS
#==============
RUN apt-get update -y
RUN apt-get install bzip2 libfreetype6 libfontconfig1  -y
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && rm phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv /phantomjs-2.1.1-linux-x86_64 /usr/local/phantomjs-2.1.1-linux-x86_64
RUN ln -s /usr/local/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

#========================
# Selenium Configuration
#========================
ENV NODE_MAX_INSTANCES 1
ENV NODE_MAX_SESSION 1
ENV NODE_REGISTER_CYCLE 5000
COPY generate_config /opt/selenium/generate_config
RUN chmod +x /opt/selenium/generate_config \
  && chown -R seluser:seluser /opt/selenium

RUN chown -R seluser:seluser /opt/selenium

#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

USER seluser

# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

CMD ["/opt/bin/entry_point.sh"]
