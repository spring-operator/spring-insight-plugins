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

package com.springsource.insight.plugin.eclipse.persistence;

import org.aspectj.lang.JoinPoint;
import org.eclipse.persistence.queries.DatabaseQuery;
import org.eclipse.persistence.sessions.Session;

import com.springsource.insight.intercept.operation.Operation;

/**
 * 
 */
public aspect SessionQueryOperationCollectionAspect extends EclipsePersistenceCollectionAspect {
    public SessionQueryOperationCollectionAspect () {
        super(EclipsePersistenceDefinitions.QUERY, "Execute query");
    }

    public pointcut executeQuery () : execution(* Session+.executeQuery(..));
    // using cflowbelow in case methods delegate from one another
    public pointcut collectionPoint() : executeQuery() && (!cflowbelow(executeQuery()));

    @Override
    protected Operation createOperation(JoinPoint jp) {
        String  queryName=resolveQueryName(jp.getArgs());
        return createOperation(jp, queryName);
    }

    static String resolveQueryName (Object ... args) {
        if ((args == null) || (args.length <= 0)) {
            return "unknown";
        }
        
        Object  arg0=args[0];
        if (arg0 instanceof String) {
            return (String) arg0;
        }
        
        if (arg0 instanceof DatabaseQuery) {
            return ((DatabaseQuery) arg0).getName();
        }

        // TODO consider logging a warning
        return arg0.getClass().getSimpleName();
    }
}
