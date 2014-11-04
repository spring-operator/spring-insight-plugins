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
package com.springsource.insight.plugin.ehcache;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

import org.aspectj.lang.JoinPoint;

import com.springsource.insight.intercept.operation.Operation;

/**
 *
 */
public aspect EhcacheReplaceOperationCollectionAspect extends EhcacheMethodOperationCollectionAspect {
    public EhcacheReplaceOperationCollectionAspect() {
        super();
    }

    public pointcut ehcacheCollectionPoint()
            : execution(* Ehcache+.replace(Element,Element))
            || execution(* Ehcache+.replace(Element))
            ;

    @Override
    protected Operation createOperation(final JoinPoint jp) {
        return createReplaceOperation(super.createOperation(jp), (Ehcache) jp.getTarget(), jp.getArgs());
    }

    Operation createReplaceOperation(final Operation op, final Ehcache cache, final Object... args) {
        final Element oldElement = (Element) args[0];
        initCommonFields(op, cache, EhcacheDefinitions.RPL_METHOD, oldElement.getObjectKey());

        final Object value;
        if (args.length > 1) {
            final Element newElement = (Element) args[1];
            value = newElement.getObjectValue();
        } else {    // this is a one argument replacement - i.e., the element contains BOTH key and value
            value = oldElement.getObjectValue();
        }
        op.putAnyNonEmpty(EhcacheDefinitions.VALUE_ATTRIBUTE, (value != null) ? value.getClass().getSimpleName() : null);

        return op;
    }
}
