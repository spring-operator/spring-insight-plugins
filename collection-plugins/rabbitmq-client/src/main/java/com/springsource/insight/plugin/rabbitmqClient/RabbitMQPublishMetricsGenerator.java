/**
 * Copyright (c) 2009-2011 VMware, Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


package com.springsource.insight.plugin.rabbitmqClient;


public class RabbitMQPublishMetricsGenerator extends AbstractRabbitMetricsGenerator {
    private static final RabbitMQPublishMetricsGenerator INSTANCE = new RabbitMQPublishMetricsGenerator();

    private RabbitMQPublishMetricsGenerator() {
        super(RabbitPluginOperationType.PUBLISH);
    }

    public static final RabbitMQPublishMetricsGenerator getInstance() {
        return INSTANCE;
    }
}